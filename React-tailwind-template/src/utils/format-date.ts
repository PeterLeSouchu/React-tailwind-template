/* Function to return date f rom timestamp (use it for sql timestamp)

 Example : 
  const timestamp = 2024-12-06 17:41:55.814945+00
  const date = formatDate(timestamp);
  the nav return : 06/12/2024
  
*/

const formatDate = (isoString: string) => {
  const date = new Date(isoString);
  const day = String(date.getDate()).padStart(2, '0');
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const year = date.getFullYear(); //
  return `${day}/${month}/${year}`;
};

export default formatDate;
